package it.portaleSTI.DTO;

import javax.servlet.http.HttpServletRequest;

public class DatatablesParamsDTO {
	/// <summary>
    /// Request sequence number sent by DataTable, same value must be returned in response
    /// </summary>       
    public String sEcho;

    /// <summary>
    /// Text used for filtering
    /// </summary>
    public String sSearch;

    /// <summary>
    /// Number of records that should be shown in table
    /// </summary>
    public int iDisplayLength;

    /// <summary>
    /// First record that should be shown(used for paging)
    /// </summary>
    public int iDisplayStart;

    /// <summary>
    /// Number of columns in table
    /// </summary>
    public int iColumns;	

    /// <summary>
    /// Number of columns that are used in sorting
    /// </summary>
    public int iSortingCols;
    
    /// <summary>
    /// Index of the column that is used for sorting
    /// </summary>
    public int iSortColumnIndex;
    
    /// <summary>
    /// Sorting direction "asc" or "desc"
    /// </summary>
    public String sSortDirection;

    /// <summary>
    /// Comma separated list of column names
    /// </summary>
    public String sColumns;
    
    public DatatablesParamsDTO(HttpServletRequest request) {
		if(request.getParameter("sEcho")!=null && request.getParameter("sEcho")!= "")
		{
			this.sEcho = request.getParameter("sEcho");
			this.sSearch = request.getParameter("sSearch");
			this.sColumns = request.getParameter("sColumns");
			this.iDisplayStart = Integer.parseInt( request.getParameter("iDisplayStart") );
			this.iDisplayLength = Integer.parseInt( request.getParameter("iDisplayLength") );
			this.iColumns = Integer.parseInt( request.getParameter("iColumns") );
			this.iSortingCols = Integer.parseInt( request.getParameter("iSortingCols") );
			this.iSortColumnIndex = Integer.parseInt(request.getParameter("iSortCol_0"));
			this.sSortDirection = request.getParameter("sSortDir_0");		
		}

	}
    
}
