package controller;

import dal.AccountDAO;
import dal.DiscountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Accounts;
import model.Discounts;

import java.io.IOException;
import java.util.List;


@WebServlet(name = "DiscountListServlet", value = "/listDiscounts")
public class DiscountsListServlet extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 5;
    ;@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DiscountDAO discountDAO = new DiscountDAO();
        AccountDAO accountDAO = new AccountDAO();
        int page = 1;
        String pageStr = request.getParameter("page");

        if (pageStr != null) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        // Tổng số bản ghi
        int totalRecords = discountDAO.getTotalRecords();
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        if(page > totalPages) page = totalPages;

        List<Discounts> discountsList = discountDAO.getDiscountsByPage((page-1)*RECORDS_PER_PAGE,RECORDS_PER_PAGE);
        List< Accounts> accountsList = accountDAO.getAllAccounts();
        // Nếu trang hiện tại không có dữ liệu và lớn hơn 1, giảm trang xuống
        if (discountsList.isEmpty() && page > 1) {
            page--;
            discountsList = discountDAO.getDiscountsByPage((page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        }
        request.setAttribute("discountsList", discountsList);
        request.setAttribute("accountsList", accountsList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/views/admin/jsp/viewListDiscounts.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}