package utils;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;


public class Utils {
    public static JSONObject getJsonFromRequest(HttpServletRequest request) throws IOException{
    BufferedReader br = request.getReader();
    String json = "";
    if(br != null){
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
}
