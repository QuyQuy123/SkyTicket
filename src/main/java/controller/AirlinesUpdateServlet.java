
package controller;

import dal.AirlinesDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Airlines;

import java.io.File;
import java.io.IOException;
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
@WebServlet("/updateAirline") //
public class AirlinesUpdateServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "img";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        AirlinesDAO airlinesDAO = new AirlinesDAO();

        Airlines airline = new Airlines();
        airline = airlinesDAO.getAirlineById(id);

        if (airline == null) {
            request.setAttribute("error", "Airline not found");
            request.getRequestDispatcher("views/admin/jsp/update.jsp").forward(request, response);
        }else{
            request.setAttribute("airline", airline);
            request.getRequestDispatcher("views/admin/jsp/updateAirline.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("airlineId"));
        String airlineName = request.getParameter("name");
        String information = request.getParameter("information");
        int numberOfSeatsOnVipRow = Integer.parseInt(request.getParameter("numberOfSeatsOnVipRow"));
        int numberOfSeatsOnVipColumn = Integer.parseInt(request.getParameter("numberOfSeatsOnVipColumn"));
        int numberOfSeatsOnEcoRow = Integer.parseInt(request.getParameter("numberOfSeatsOnEcoRow"));
        int numberOfSeatsOnEcoColumn = Integer.parseInt(request.getParameter("numberOfSeatsOnEcoColumn"));
        int status = Integer.parseInt(request.getParameter("status"));



        Part filePart = request.getPart("airlineImage");
        String fileName = "";

        if (filePart != null && filePart.getSize() > 0) {
            fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);
        } else {
            fileName = request.getParameter("oldImage");
        }


        AirlinesDAO airlineDAO = new AirlinesDAO();
        Airlines airline = airlineDAO.getAirlineById(id);
        boolean validation = true;
        String err = "";

        if (airlineName == null || airlineName.trim().isEmpty()) {
            err = "Airline name cannot be empty";
            validation = false;
        } else if (airline.getAirlineName().equals(airlineName)
            && airline.getNumberOfSeatsOnVipRow() == numberOfSeatsOnVipRow
            && airline.getNumberOfSeatsOnVipColumn() == numberOfSeatsOnVipColumn
            && airline.getNumberOfSeatsOnEconomyRow() == numberOfSeatsOnEcoRow
            && airline.getNumberOfSeatsOnEconomyColumn() == numberOfSeatsOnEcoColumn
        && airline.getImage() == fileName) {
            err = "Airline already exists";
            validation = false;
        }

        if (validation) {
            airline.setAirlineName(airlineName);
            airline.setInformation(information);
            airline.setImage(fileName);
            airline.setNumberOfSeatsOnVipRow(numberOfSeatsOnVipRow);
            airline.setNumberOfSeatsOnVipColumn(numberOfSeatsOnVipColumn);
            airline.setNumberOfSeatsOnEconomyRow(numberOfSeatsOnEcoRow);
            airline.setNumberOfSeatsOnEconomyColumn(numberOfSeatsOnEcoColumn);
            airline.setStatus(status);
            boolean success = airlineDAO.updateAirline(airline);

            if (success) {
                request.setAttribute("msg", "Airline update successfully");
                request.setAttribute("airline", airline);
                request.getRequestDispatcher( "/views/admin/jsp/updateAirline.jsp").forward(request, response);
            } else {
                request.setAttribute("err", "Airline update failed");
                request.setAttribute("airline", airline);
                request.getRequestDispatcher("/views/admin/jsp/updateAirline.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("err", err);
            request.setAttribute("airline", airline);
            request.getRequestDispatcher("/views/admin/jsp/updateAirline.jsp").forward(request, response);
        }
    }
}
