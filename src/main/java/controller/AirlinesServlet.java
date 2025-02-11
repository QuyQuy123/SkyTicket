package controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import dal.AirlinesDAO;
import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Airlines;

@WebServlet("/airlines")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AirlinesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "uploads";



    // Xử lý yêu cầu GET
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect( request.getContextPath()+ "/views/admin/jsp/addAirline.jsp");
    }

    // Xử lý yêu cầu POST
    // Giới hạn 16MB
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String airlineName = request.getParameter("name");
        String information = request.getParameter("information");
        int classVip = Integer.parseInt(request.getParameter("classVip"));
        int classEconomy = Integer.parseInt(request.getParameter("classEconomy"));
        int status = Integer.parseInt(request.getParameter("status"));

        // Xử lý file upload
        Part filePart = request.getPart("airlineImage");
        String fileName = filePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        // Lưu vào database
        Airlines airline = new Airlines( airlineName, fileName, UPLOAD_DIR + "/" + fileName, information, status, classVip, classEconomy);
        AirlinesDAO airlineDAO = new AirlinesDAO();
        boolean success = airlineDAO.addAirline(airline);

        re
        if (success) {
            session.setAttribute("msg", "Airline added successfully");
            response.sendRedirect(request.getContextPath() +"/views/admin/jsp/addAirline.jsp");
            //request.getRequestDispatcher( "/views/admin/jsp/addAirline.jsp").forward(request, response);
        } else {
            response.sendRedirect("error.jsp"); // Điều hướng nếu thất bại
        }

    }
}
