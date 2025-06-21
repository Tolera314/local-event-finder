package Servlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.file.*;

@MultipartConfig
public class AEventServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String location = request.getParameter("eventLocation");
        String time = request.getParameter("eventTime");
        String price = request.getParameter("eventPrice");
        String vipPrice = request.getParameter("vipPrice");

        Part filePart = request.getPart("eventImage");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + "uploads";

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        // Save to database (pseudo-code)
        // Database.saveEvent(location, time, price, vipPrice, filePath);

        response.sendRedirect("adminInput.jsp");
    }
}
