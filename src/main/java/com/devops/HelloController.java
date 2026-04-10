package com.devops;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/")
    public String home() {
        return "FUNCIONANDO DE NUEVO 🚀";
    }

    @GetMapping("/saludo")
    public String saludo() {
        return "Hola desde Spring Boot XD 👋";
    }
}