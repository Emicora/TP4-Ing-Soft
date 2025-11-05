package com.mycompany.myapp.web.rest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class LogTestResource {

    private final Logger log = LoggerFactory.getLogger(LogTestResource.class);

    @GetMapping("/test-log")
    public ResponseEntity<String> testLog() {
        log.info("✅ Test INFO desde JHipster hacia ELK");
        log.warn("⚠️ Test WARN desde JHipster hacia ELK");
        log.error("❌ Test ERROR desde JHipster hacia ELK");
        return ResponseEntity.ok("Logs enviados a Logstash!");
    }
}
