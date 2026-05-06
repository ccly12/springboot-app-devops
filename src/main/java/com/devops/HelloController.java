package com.devops;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/saludo")
    public String saludo() {
        return "¡Hola!  API de Spring Boot está funcionando perfectamente. ¡Bienvenido a mi proyecto DevOps!";
    }
}