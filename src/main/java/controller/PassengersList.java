package controller;


import dal.AccountDAO;
import dal.CountriesDAO;
import dal.LocationsDAO;
import dal.PassengersDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Locations;
import model.Passengers;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/listPassengersURL")
public class PassengersList extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 6;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PassengersDAO passengersDAO = new PassengersDAO();
        AccountDAO accountDAO = new AccountDAO();

        int page = 1;
        String pageStr = request.getParameter("page");

        if (pageStr != null) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1; // Không cho phép trang nhỏ hơn 1
            } catch (NumberFormatException e) {
                page = 1; // Nếu có lỗi thì về trang 1
            }
        }

        int totalRecords = passengersDAO.getTotalRecords();
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        // Nếu page lớn hơn totalPages nhưng không có dữ liệu, đưa về trang cuối cùng có dữ liệu
        if (page > totalPages) page = totalPages;

        List<Passengers> listPassengers = passengersDAO.getLocationsByPage((page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);

        // Nếu danh sách lấy về rỗng mà page > 1, quay lại trang trước
        if (listPassengers.isEmpty() && page > 1) {
            page--;
            listPassengers = passengersDAO.getLocationsByPage((page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        }

        request.setAttribute("passengers", listPassengers);
        request.setAttribute("accounts", accountDAO.getAllAccounts());
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/views/admin/jsp/viewListPassengers.jsp").forward(request, response);
    }
}
