package controller;

import dal.AirlinesDAO;
import dal.NewsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Airlines;
import model.News;

import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/manageNews")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class ManageNewsServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "img";


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        String action = request.getParameter("action");
        AirlinesDAO airlinesDAO = new AirlinesDAO();


        if (action == null) {
            action = "list";
        }

        List<Airlines> airlinesList = airlinesDAO.getAllAirlines();

        request.setAttribute("airlinesList", airlinesList);
        String rep = "/views/admin/jsp/manageNewsForm.jsp";
        switch (action) {
            case "add":
                request.setAttribute("news", null);
                request.setAttribute("isAdd", true);
                request.getRequestDispatcher(rep).forward(request, response);
                break;

            case "update":
                int id = Integer.parseInt(request.getParameter("id"));
                NewsDAO newsDAO = new NewsDAO();
                News news = newsDAO.getNewsById(id);
                request.setAttribute("news", news);
                request.setAttribute("isUpdate", true);
                request.getRequestDispatcher(rep).forward(request, response);
                break;

            case "view":
                int id1 = Integer.parseInt(request.getParameter("id"));
                NewsDAO news1DAO = new NewsDAO();
                News news1 = news1DAO.getNewsById(id1);
                request.setAttribute("news", news1);
                request.setAttribute("isView", true);
                request.getRequestDispatcher(rep).forward(request, response);
                break;

            case "list":
                break;

            default:
                break;

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        AirlinesDAO airlinesDAO = new AirlinesDAO();

        List<Airlines> airlinesList = airlinesDAO.getAllAirlines();
        request.setAttribute("airlinesList", airlinesList);

        NewsDAO newsDAO = new NewsDAO();
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        int airlineId = Integer.parseInt(request.getParameter("airline"));
        int status = Integer.parseInt(request.getParameter("status"));

        // Xử lý file upload
        Part filePart = request.getPart("imgNews");
        String fileName = request.getParameter("previewNewsImage"); // Lấy file cũ mặc định

        if (filePart != null && filePart.getSize() > 0) {  // Nếu có file mới
            fileName = filePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs(); // Tạo thư mục nếu chưa có
            }

            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);
        }

        switch (action) {
            case "add":
                News news = new News(title, "img/" + fileName, content, airlineId, status);
                boolean success = newsDAO.addNews(news);
                request.setAttribute("isAdd", true);

                if (success) {
                    request.setAttribute("msg", "News add successfully!");
                } else {
                    request.setAttribute("msg", "Failed to add news.");
                }
                break;
            case "update":
                int id = Integer.parseInt(request.getParameter("id"));
                News newsUpdate = newsDAO.getNewsById(id);
                request.setAttribute("isUpdate", true);

                newsUpdate.setTitle(title);
                newsUpdate.setContent(content);
                newsUpdate.setAirlineId(airlineId);
                newsUpdate.setStatus(status);
                newsUpdate.setImg("img/" + fileName);

                boolean check = newsDAO.updateNews(newsUpdate);
                request.setAttribute("news", newsUpdate);
                if (check) {
                    request.setAttribute("msg", "News update successfully!");
                } else {
                    request.setAttribute("msg", "Failed to update news.");
                }
            case "delete":
                int id1 = Integer.parseInt(request.getParameter("id"));
                boolean check1 = newsDAO.updateNewsStatus(id1, 0);
                if(check1){
                    response.setStatus(HttpServletResponse.SC_OK);
                }
                break;
            case "restore":
                int id2 = Integer.parseInt(request.getParameter("id"));
                boolean check2 = newsDAO.updateNewsStatus(id2, 1);
                if(check2){
                    response.setStatus(HttpServletResponse.SC_OK);
                }
                break;
            default:
                break;
        }

        request.getRequestDispatcher("/views/admin/jsp/manageNewsForm.jsp").forward(request, response);
    }
}
