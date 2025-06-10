package controller;
import java.io.IOException;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import model.UserGoogle;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import org.apache.http.client.ClientProtocolException;

public class GoogleLogin {

    public static final String GOOGLE_CLIENT_ID = "320434410566-roa3pt0l2daks98s6r9o32t9jn4akq79.apps.googleusercontent.com";

    public static final String GOOGLE_CLIENT_SECRET = "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";

    public static final String GOOGLE_REDIRECT_URI = "http://localhost:8090/LoginGoogle";

    public static final String GOOGLE_GRANT_TYPE = "authorization_code";

    public static final String GOOGLE_LINK_GET_TOKEN = "https://oauth2.googleapis.com/token";

    public static final String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";

    public String getToken(String code) throws ClientProtocolException, IOException {

        String response = Request.Post(GOOGLE_LINK_GET_TOKEN)
                .bodyForm(
                        Form.form()
                                .add("client_id", GOOGLE_CLIENT_ID)
                                .add("client_secret", GOOGLE_CLIENT_SECRET)
                                .add("redirect_uri", GOOGLE_REDIRECT_URI)
                                .add("code", code)
                                .add("grant_type", GOOGLE_GRANT_TYPE)
                                .build()
                )
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);

        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");

        return accessToken;

    }



    public UserGoogle getUserInfo(final String accessToken) throws ClientProtocolException, IOException {

        String link = GOOGLE_LINK_GET_USER_INFO + accessToken;

        String response = Request.Get(link).execute().returnContent().asString();

        UserGoogle googlePojo = new Gson().fromJson(response, UserGoogle.class);

        return googlePojo;

    }

    public static void main(String[] args) throws IOException {
        String code = "4%2F0ASVgi3KDYg2gT3j-G-CRTWagIF6XLojw16yfqVXWElHuPPPRhTtnm2owGQZZjUsg0APxEg";
        GoogleLogin googleLogin = new GoogleLogin();
        String accessToken = googleLogin.getToken(code);
        System.out.println(accessToken);
    }


}