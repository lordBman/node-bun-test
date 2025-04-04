package com.bsoft.test.test.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
public class UsersController {
    @GetMapping("/users/{name}")
    public ResponseEntity<String> greet(@PathVariable String name) {
        return ResponseEntity.ok(String.format("Hello %s!", name));
    }
}
