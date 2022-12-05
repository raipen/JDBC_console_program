package utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.charset.Charset;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class Utils {
    public static JSONObject getJsonFromRequest(HttpServletRequest request) throws IOException {
        BufferedReader br = request.getReader();
        String json = "";
        if (br != null) {
            json = br.readLine();
        }
        JSONParser parser = new JSONParser();
        JSONObject jsonObj = null;
        try {
            jsonObj = (JSONObject) parser.parse(json);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return jsonObj;
    }

    public static String getSha512(String pwd) {
		String encPwd = "";

		try {
			// SHA-512 내장 메소드 사용 어떤식으로 암호화 처리 되는지는 알 수 없음
			MessageDigest md = MessageDigest.getInstance("SHA-512");
			byte[] bytes = pwd.getBytes(Charset.forName("UTF-8"));
			md.update(bytes); // 암호화 처리된 게 bytes 안에 있음(아직)
			
			// 암호화 처리 된게 문자열로 바뀐다.
			encPwd = Base64.getEncoder().encodeToString(md.digest());
			
			
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		return encPwd;
	}
}
