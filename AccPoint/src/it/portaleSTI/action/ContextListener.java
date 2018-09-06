package it.portaleSTI.action;

import java.io.File;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
 
import org.apache.log4j.PropertyConfigurator;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SimpleScheduleBuilder;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.impl.StdSchedulerFactory;
 
@WebListener("application context listener")
public class ContextListener implements ServletContextListener {
 
    /**
     * Initialize log4j when the application is being started
     */
    @Override
    public void contextInitialized(ServletContextEvent event) {
        // initialize log4j here
        ServletContext context = event.getServletContext();
        String log4jConfigFile = context.getInitParameter("log4j-config-location");
        String fullPath = context.getRealPath("") + File.separator + log4jConfigFile;
         
        try {
			startScheduler();
		} catch (SchedulerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        PropertyConfigurator.configure(fullPath);
         
    }
     
    @Override
    public void contextDestroyed(ServletContextEvent event) {
        // do nothing
    }  
    
    
    public void startScheduler() throws SchedulerException {
    	
    	JobDetail job = JobBuilder.newJob(AggiornaCampioneScheduler.class).withIdentity("aggiornaCampione", "group1").build();

        Trigger trigger = TriggerBuilder
                .newTrigger()
                .withIdentity("aggiornaCampione", "group1")
                .withSchedule(SimpleScheduleBuilder.simpleSchedule().withIntervalInHours(12).repeatForever())
                .build();

        Scheduler scheduler = new StdSchedulerFactory().getScheduler();
        scheduler.start();
        scheduler.scheduleJob(job, trigger);
    }
}
