package com.example.mybole.utils;

public class Result <T>{
    private int code;
    private String msg;
    private T data;
    
    public Result() {}
    
    public Result(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }
    
    public Result(int code, String msg, T data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }
    
    public static <T> Result<T> success(T data) {
        return new Result<>(200, "success", data);
    }
    
    public static <T> Result<T> success(String msg, T data) {
        return new Result<>(200, msg, data);
    }
    
    public static <T> Result<T> error(String msg) {
        return new Result<>(500, msg);
    }
    
    public static <T> Result<T> error(int code, String msg) {
        return new Result<>(code, msg);
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}