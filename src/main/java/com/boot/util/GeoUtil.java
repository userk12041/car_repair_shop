package com.boot.util;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.stream.Collectors;

import org.json.JSONArray;
import org.json.JSONObject;


public class GeoUtil {
    public static double[] getLatLngFromAddress(String address) {
        try {
            String apiKey = "92f5e0edb0898b4560978172b6da3ba2"; // kakao rest api key
            String url = "https://dapi.kakao.com/v2/local/search/address.json?query=" + URLEncoder.encode(address, "UTF-8");

            HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "KakaoAK " + apiKey);

            int responseCode = conn.getResponseCode();

            BufferedReader br;
            if (responseCode == 200) {
                br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            } else {
                br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
            }
            
//            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            String response = br.lines().collect(Collectors.joining());

            // 카카오 API 응답 JSON 콘솔 출력 test
            System.out.println("Kakao API response JSON:");
            System.out.println(response);
            
            JSONObject json = new JSONObject(response);
            JSONArray documents = json.getJSONArray("documents");

            if (documents.length() > 0) {
                JSONObject location = documents.getJSONObject(0);
                JSONObject addressInfo = location.getJSONObject("address");

                double lat = addressInfo.getDouble("y"); // 위도
                double lng = addressInfo.getDouble("x"); // 경도

                return new double[]{lat, lng};
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new double[]{0.0, 0.0}; // 실패 시 기본값
    }
}
