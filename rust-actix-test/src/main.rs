use actix_web::{get, web, App, HttpResponse, HttpServer, Responder};

#[get("/")]
async fn hello() -> impl Responder {
    HttpResponse::Ok().body("Hello world!")
}

async fn not_found() -> impl Responder {
    HttpResponse::NotFound().body("Page not found")
}

#[get("/users/{name}")]
async fn user_info(path: web::Path<String>) -> impl Responder {
    let name = path.into_inner();
    HttpResponse::Ok().body(format!("Hello {}!", name))
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let server = HttpServer::new(|| {
        App::new().service(hello).default_service(web::to(not_found)).service(user_info)
    });    
    server.workers(4) // Typically 1.5-2x CPU cores
    .backlog(1024) // Socket backlog
    .max_connections(100_000) // Max simultaneous connections
    .max_connection_rate(10_000) // Max new connections/sec
    .bind(("127.0.0.1", 3000))?.run().await
}
