package controller;

import java.io.File;
import java.io.IOException;

import dal.AirlinesDAO;
import dal.SeatsDAO;
import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Airlines;
import model.Seats;

@WebServlet("/addAirline")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AirlinesAddServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "img";



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/views/admin/jsp/addAirline.jsp");
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String airlineName = request.getParameter("name");
            String information = request.getParameter("information");
            int numberOfSeatsOnVipRow = Integer.parseInt(request.getParameter("numberOfSeatsOnVipRow"));
            int numberOfSeatsOnVipColumn = Integer.parseInt(request.getParameter("numberOfSeatsOnVipColumn"));
            int numberOfSeatsOnEcoRow = Integer.parseInt(request.getParameter("numberOfSeatsOnEcoRow"));
            int numberOfSeatsOnEcoColumn = Integer.parseInt(request.getParameter("numberOfSeatsOnEcoColumn"));
            int status = Integer.parseInt(request.getParameter("status"));

            // Xử lý file upload
            Part filePart = request.getPart("airlineImage");
            String fileName = filePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);



            Airlines airline = new Airlines(airlineName, fileName, information, status, numberOfSeatsOnVipRow, numberOfSeatsOnVipColumn, numberOfSeatsOnEcoRow, numberOfSeatsOnEcoColumn);
            AirlinesDAO airlineDAO = new AirlinesDAO();

            int success = airlineDAO.addAirline(airline);

            if (success != 0) {
                int airlineId = success;
                SeatsDAO seatsDAO = new SeatsDAO();
                for (int i = 1; i <= numberOfSeatsOnVipRow * numberOfSeatsOnVipColumn; i++) {
                    Seats seat = new Seats(airlineId, 1, i, "Business", 0);
                    seatsDAO.createSeat(seat); //nhwos theem hamf check
                }
                for (int i = 1; i <= numberOfSeatsOnEcoRow * numberOfSeatsOnEcoColumn; i++) {
                    Seats seat = new Seats(airlineId, 1, i, "Economy", 0);
                    seatsDAO.createSeat(seat);
                }
                request.setAttribute("msg", "Airline added successfully");
                request.getRequestDispatcher("/views/admin/jsp/addAirline.jsp").forward(request, response);
            } else {
                response.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
