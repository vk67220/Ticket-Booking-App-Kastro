package com.moviebooking.apigateway.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;

@Configuration
public class RouteConfig {

    @Value("${user.service.url}")
    private String userServiceUrl;

    @Value("${movie.service.url}")
    private String movieServiceUrl;

    @Value("${booking.service.url}")
    private String bookingServiceUrl;

    @Value("${payment.service.url}")
    private String paymentServiceUrl;

    @Bean
    public RouteLocator customRouteLocator(RouteLocatorBuilder builder) {
        return builder.routes()
                // User Service Routes
                .route("user-service", r -> r
                        .path("/api/users/**")
                        .uri(userServiceUrl))
                .route("auth-service", r -> r
                        .path("/api/auth/**")
                        .uri(userServiceUrl))
                
                // Movie Service Routes
                .route("movies-service", r -> r
                        .path("/api/movies/**")
                        .uri(movieServiceUrl))
                .route("theaters-service", r -> r
                        .path("/api/theaters/**")
                        .uri(movieServiceUrl))
                .route("showtimes-service", r -> r
                        .path("/api/showtimes/**")
                        .uri(movieServiceUrl))
                
                // Booking Service Routes
                .route("bookings-service", r -> r
                        .path("/api/bookings/**")
                        .uri(bookingServiceUrl))
                .route("seats-service", r -> r
                        .path("/api/seats/**")
                        .uri(bookingServiceUrl))
                .route("tickets-service", r -> r
                        .path("/api/tickets/**")
                        .uri(bookingServiceUrl))
                
                // Payment Service Routes
                .route("payments-service", r -> r
                        .path("/api/payments/**")
                        .uri(paymentServiceUrl))
                
                // Frontend Routes (static content)
                .route("frontend-route", r -> r
                        .path("/**")
                        .uri("http://frontend:80"))
                .build();
    }
}