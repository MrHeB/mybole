package com.example.mybole.utils;

public class Result <T>{
    int code;
    String msg;
    T data;
    public Result(int code, String msg) {
        this.code = code;
    };

}
