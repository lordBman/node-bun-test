package com.bsoft.test.test.controllers;

import com.bsoft.test.test.models.NotFound;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
public class FallbackController {

    @RequestMapping(value = "/**", method = {RequestMethod.GET, RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE, RequestMethod.PATCH})
    public ResponseEntity<NotFound> handleUnknownRoutes() {
        NotFound notFound = new NotFound("Page not found", "The requested resource was not found");

        return new ResponseEntity<>(notFound, HttpStatus.NOT_FOUND);
    }
}
