package it.portaleSTI.bo;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.GeneralSecurityException;
import java.security.KeyStore;
import java.security.cert.Certificate;
import java.security.cert.CertificateFactory;
import java.text.SimpleDateFormat;
import java.time.OffsetDateTime;
import java.util.Collection;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManagerFactory;

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParseException;
import com.google.gson.JsonParser;

import it.portaleSTI.DAO.GestioneSpedizioneDAO;
import it.portaleSTI.DTO.CorriereDTO;
import it.portaleSTI.DTO.SpedizioneDTO;

public class GestioneSpedizioneBO {
	
	public static List<SpedizioneDTO> getListaSpedizioni(Session session){		
		return GestioneSpedizioneDAO.getListaSpedizioniPacchiAperti(session);
	}
	
	public static List<CorriereDTO> getListaCorrieri(Session session){
		return GestioneSpedizioneDAO.getListaCorrieri(session);
	}

    public static void saveSpedizione(SpedizioneDTO spedizione, Session session) {
        session.save(spedizione);
    }
    
    public static void updateSpedizone(SpedizioneDTO spedizione, Session session) {
    	session.update(spedizione);
    }
    
    public static SpedizioneDTO getSpedizioneByIdDdt(int id_ddt,Session session) {
    	return GestioneSpedizioneDAO.getSpedizioneByIdDdt(id_ddt, session);
    }
    
    public static SpedizioneDTO getSpedizioneById(int id_spedizione,Session session) {
    	return GestioneSpedizioneDAO.getSpedizioneById(id_spedizione, session);
    }

    public static String send(SpedizioneDTO spedizione,
            String baseUrl, String apiToken, Path caPem, String tipoOperazione)
            throws IOException {

        String idPacco = valore(spedizione.getId_pacco());
        if (idPacco.isEmpty()) {
            throw new IllegalArgumentException("ID pacco mancante");
        }

        String risposta = null;
        Map<String, String> pacco = new LinkedHashMap<String, String>();
        if(tipoOperazione.equals("invio")) {
        pacco.put("id_pacco", idPacco);
        pacco.put("destinatario", valore(spedizione.getDestinatario()));
        pacco.put("co", valore(spedizione.getPresso()));
        pacco.put("corriere", valore(spedizione.getCorriere()));
        pacco.put("tracking_number", valore(spedizione.getCodice_tracking()));

        Date dataSpedizione = spedizione.getData_spedizione();
        pacco.put("data_spedizione", dataSpedizione == null
                ? ""
                : new SimpleDateFormat("yyyy-MM-dd").format(dataSpedizione));
        pacco.put("referente", valore(spedizione.getReferente()));
        pacco.put("telefono", valore(spedizione.getTelefono()));
        pacco.put("indirizzo", valore(spedizione.getIndirizzo()));
        pacco.put("cap", valore(spedizione.getCap()));
        pacco.put("citta", valore(spedizione.getCitta()));
        pacco.put("provincia", valore(spedizione.getProvincia()));
        pacco.put("nazione", valore(spedizione.getNazione()));
        pacco.put("note", valore(spedizione.getNote()));
        pacco.put("erp_updated_at", OffsetDateTime.now().withNano(0).toString());
        

         risposta = inviaPacco(pacco, baseUrl, apiToken, caPem);
        } else if(tipoOperazione.equals("stato_spedizione")) {
         risposta = recuperaStatoSpedizione(idPacco, baseUrl, apiToken, caPem);
        }

        JsonElement esitoApi;
        try {
            esitoApi = new JsonParser().parse(risposta);
        } catch (JsonParseException e) {
            throw new IOException("Risposta non valida da STI Etichette", e);
        }

        if (!esitoApi.isJsonObject()) {
            throw new IOException("Risposta non valida da STI Etichette");
        }

      
        return risposta;


    }

    private static String inviaPacco(Map<String, String> pacco,
            String baseUrl, String apiToken, Path caPem) throws IOException {

        if (apiToken == null || apiToken.codePoints().allMatch(Character::isWhitespace)) {
            throw new IllegalArgumentException("Token API mancante");
        }
        if (baseUrl == null || baseUrl.trim().isEmpty()) {
            throw new IllegalArgumentException("Indirizzo API mancante");
        }

        String root = baseUrl.trim().replaceAll("/+$", "");
        boolean https = root.startsWith("https://");
        if (!https && !root.matches("http://(?:localhost|127\\.0\\.0\\.1|\\[::1\\])(?::[0-9]+)?")) {
            throw new IllegalArgumentException("HTTP consentito solo su localhost");
        }
        if (caPem != null && !https) {
            throw new IllegalArgumentException("La CA dedicata richiede HTTPS");
        }

        URI endpoint = URI.create(root).resolve("/api/integration/v1/parcels");
        HttpURLConnection connessione = (HttpURLConnection) endpoint.toURL().openConnection();

        try {
            if (caPem != null) {
                HttpsURLConnection connessioneHttps = (HttpsURLConnection) connessione;
                connessioneHttps.setSSLSocketFactory(creaContestoSsl(caPem).getSocketFactory());
            }

            connessione.setRequestMethod("POST");
            connessione.setConnectTimeout(5000);
            connessione.setReadTimeout(15000);
            connessione.setInstanceFollowRedirects(false);
            connessione.setRequestProperty("Accept", "application/json");
            connessione.setRequestProperty("Authorization", "Bearer " + apiToken);
            connessione.setRequestProperty("Content-Type", "application/json; charset=UTF-8");

            byte[] json = new Gson().toJson(pacco).getBytes(StandardCharsets.UTF_8);
            connessione.setDoOutput(true);
            connessione.setFixedLengthStreamingMode(json.length);

            try (OutputStream out = connessione.getOutputStream()) {
                out.write(json);
            } catch (IOException e) {
                throw new IOException(
                    "Errore di connessione durante l'invio dell'spedizione a STI Etichette: "
                    + e.getMessage(), e
                );
            }

            int stato = connessione.getResponseCode();
            
            if (stato < 200 || stato >= 300) {
                String messaggio;

                switch (stato) {
                    case 401:
                        messaggio = "Token API mancante o non valido. Verifica la configurazione.";
                        break;
                    case 403:
                        messaggio = "Accesso negato. Verifica che l'IP sia autorizzato e che la connessione usi HTTPS.";
                        break;
                    case 409:
                        messaggio = "Invio in conflitto. L'ID potrebbe essere annullato, "
                                + "l'aggiornamento superato o la spedizione già lavorata.";
                        break;
                    case 422:
                        messaggio = "Dati dell'spedizione non validi. Controlla i campi obbligatori, "
                                + "l'ID pacco e il formato della data.";
                        break;
                    default:
                        messaggio = "Errore durante la comunicazione con STI Etichette.";
                        break;
                }

                IOException errore = new IOException(
                        "STI Etichette (HTTP " + stato + "). " + messaggio
                );

                if (stato == 409 || stato == 422) {
                    try (InputStream in = connessione.getErrorStream();
                         ByteArrayOutputStream dettaglio = new ByteArrayOutputStream()) {

                        if (in != null) {
                            byte[] buffer = new byte[4096];
                            int letti;

                            while ((letti = in.read(buffer)) != -1) {
                                dettaglio.write(buffer, 0, letti);
                            }

                            if (dettaglio.size() > 0) {
                                errore.initCause(new IOException(
                                        new String(dettaglio.toByteArray(), StandardCharsets.UTF_8)
                                ));
                            }
                        }
                    } catch (IOException e) {
                        errore.addSuppressed(e);
                    }
                }

                throw errore;
            }
            try (InputStream in = connessione.getInputStream();
                 ByteArrayOutputStream risposta = new ByteArrayOutputStream()) {
                byte[] buffer = new byte[4096];
                int letti;
                while ((letti = in.read(buffer)) != -1) {
                    risposta.write(buffer, 0, letti);
                }
                return new String(risposta.toByteArray(), StandardCharsets.UTF_8);
            }
        } finally {
            connessione.disconnect();
        }
    }

    private static SSLContext creaContestoSsl(Path caPem) throws IOException {
        try {
            CertificateFactory factory = CertificateFactory.getInstance("X.509");
            Collection<? extends Certificate> certificati;
            try (InputStream in = Files.newInputStream(caPem)) {
                certificati = factory.generateCertificates(in);
            }
            if (certificati.isEmpty()) {
                throw new IOException("Nessun certificato X.509 nel file CA");
            }

            KeyStore trustStore = KeyStore.getInstance(KeyStore.getDefaultType());
            trustStore.load(null, null);
            int indice = 0;
            for (Certificate certificato : certificati) {
                trustStore.setCertificateEntry("sti-erp-ca-" + (++indice), certificato);
            }

            TrustManagerFactory trustManager =
                    TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
            trustManager.init(trustStore);

            SSLContext contesto = SSLContext.getInstance("TLS");
            contesto.init(null, trustManager.getTrustManagers(), null);
            return contesto;
        } catch (GeneralSecurityException e) {
            throw new IOException("Impossibile configurare la CA di STI Etichette", e);
        }
    }

    private static String valore(String campo) {
        return campo == null ? "" : campo.trim();
    }
    
private static String recuperaStatoSpedizione(
        String idPacco, String baseUrl, String apiToken, Path caPem) throws IOException {

    if (idPacco == null || idPacco.trim().isEmpty()) {
        throw new IllegalArgumentException("ID pacco mancante");
    }
    if (apiToken == null || apiToken.codePoints().allMatch(Character::isWhitespace)) {
        throw new IllegalArgumentException("Token API mancante");
    }
    if (baseUrl == null || baseUrl.trim().isEmpty()) {
        throw new IllegalArgumentException("Indirizzo API mancante");
    }

    String root = baseUrl.trim().replaceAll("/+$", "");
    boolean https = root.startsWith("https://");

    if (!https && !root.matches("http://(?:localhost|127\\.0\\.0\\.1|\\[::1\\])(?::[0-9]+)?")) {
        throw new IllegalArgumentException("HTTP consentito solo su localhost");
    }
    if (caPem != null && !https) {
        throw new IllegalArgumentException("La CA dedicata richiede HTTPS");
    }

    URI endpoint = URI.create(root).resolve(
            "/api/integration/v1/parcels/" + encode(idPacco) + "/delivery");

    HttpURLConnection connessione = (HttpURLConnection) endpoint.toURL().openConnection();

    try {
        if (caPem != null) {
            HttpsURLConnection connessioneHttps = (HttpsURLConnection) connessione;
            connessioneHttps.setSSLSocketFactory(creaContestoSsl(caPem).getSocketFactory());
        }

        connessione.setRequestMethod("GET");
        connessione.setConnectTimeout(5000);
        connessione.setReadTimeout(15000);
        connessione.setInstanceFollowRedirects(false);
        connessione.setRequestProperty("Accept", "application/json");
        connessione.setRequestProperty("Authorization", "Bearer " + apiToken);

        int stato = connessione.getResponseCode();

        if (stato >= 200 && stato < 300) {
            try (InputStream in = connessione.getInputStream()) {
                return leggiRispostaUtf8(in);
            }
        }

        String messaggio;
        switch (stato) {
            case 401:
                messaggio = "Token API mancante o non valido.";
                break;
            case 403:
                messaggio = "Accesso negato da STI Etichette.";
                break;
            case 404:
                messaggio = "Risorsa di consegna non trovata per l'ID pacco indicato.";
                break;
            case 409:
                messaggio = "Conflitto durante il recupero dello stato della spedizione.";
                break;
            case 422:
                messaggio = "Richiesta rifiutata. Controlla l'ID pacco.";
                break;
            default:
                messaggio = "Errore durante il recupero dello stato della spedizione.";
                break;
        }

        IOException errore = new IOException(
                "STI Etichette (HTTP " + stato + "). " + messaggio);

        if (stato == 409 || stato == 422) {
            try (InputStream in = connessione.getErrorStream()) {
                if (in != null) {
                    String dettaglio = leggiRispostaUtf8(in);
                    if (!dettaglio.trim().isEmpty()) {
                        errore.initCause(new IOException(dettaglio));
                    }
                }
            } catch (IOException e) {
                errore.addSuppressed(e);
            }
        }

        throw errore;
    } finally {
        connessione.disconnect();
    }
}

private static String leggiRispostaUtf8(InputStream in) throws IOException {
    ByteArrayOutputStream risposta = new ByteArrayOutputStream();
    byte[] buffer = new byte[4096];
    int letti;

    while ((letti = in.read(buffer)) != -1) {
        risposta.write(buffer, 0, letti);
    }

    return new String(risposta.toByteArray(), StandardCharsets.UTF_8);
}
    private static String encode(String value)
            throws IOException {

        return URLEncoder.encode(value, "UTF-8");
    }

}
