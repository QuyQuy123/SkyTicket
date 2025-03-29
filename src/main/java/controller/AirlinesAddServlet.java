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
import java.util.regex.Pattern;

@WebServlet("/addAirline")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AirlinesAddServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "img";

    private boolean isValidAirlineName(String name) {
        return name.length() >= 2 && name.length() <= 255 && Pattern.matches("^[a-zA-Z0-9 ]+$", name);
    }

    private boolean isValidSeats(int value, int min, int max) {
        return value >= min && value <= max;
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

            if (!isValidAirlineName(airlineName)) {
                request.setAttribute("error", "Invalid airline name");
                request.getRequestDispatcher("/views/admin/jsp/addAirline.jsp").forward(request, response);
                return;
            }

            if (!isValidSeats(numberOfSeatsOnVipRow, 1, 4) || !isValidSeats(numberOfSeatsOnVipColumn, 1, 10) ||
                    !isValidSeats(numberOfSeatsOnEcoRow, 1, 10) || !isValidSeats(numberOfSeatsOnEcoColumn, 10, 50)) {
                request.setAttribute("error", "Invalid seat configuration");
                request.getRequestDispatcher("/views/admin/jsp/addAirline.jsp").forward(request, response);
                return;
            }

            Part filePart = request.getPart("airlineImage");
            String fileName = (filePart != null) ? System.currentTimeMillis() + "_" + filePart.getSubmittedFileName() : null;

            if (fileName == null || fileName.trim().isEmpty() || !fileName.matches(".*\\.(jpg|png)$")) {
                request.setAttribute("error", "Invalid image format");
                request.getRequestDispatcher("/views/admin/jsp/addAirline.jsp").forward(request, response);
                return;
            }


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
                    seatsDAO.createSeat(seat);
                }
                for (int i = 1; i <= numberOfSeatsOnEcoRow * numberOfSeatsOnEcoColumn; i++) {
                    Seats seat = new Seats(airlineId, 1, i, "Economy", 0);
                    seatsDAO.createSeat(seat);
                }
                request.setAttribute("msg", "Airline added successfully");
                request.setAttribute("msg1", "Seats added successfully");
                request.getRequestDispatcher("/views/admin/jsp/addAirline.jsp").forward(request, response);
            } else {
                response.sendRedirect("views/public/error.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("views/public/error.jsp");
        }
    }
}
