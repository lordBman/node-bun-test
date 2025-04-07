use axum::{
    extract::Path, http::StatusCode, routing::get, Router,
    response::IntoResponse
};

// basic handler that responds with a static string
async fn root() -> &'static str { "Hello, World!" }

async fn not_found_page() -> (StatusCode, &'static str ) {
    (StatusCode::NOT_FOUND, "page not found")
}

// Handler User function
async fn handle_user(Path(name): Path<String>) -> Result<impl IntoResponse, (StatusCode, String)> {
    if name.is_empty() {
        return Err((StatusCode::BAD_REQUEST, "Name cannot be empty".to_string()));
    }

    Ok(format!("Hello {}!", name))
}

#[tokio::main]
async fn main() {
    // initialize tracing
    //tracing_subscriber::fmt::init();

    // build our application with a route
    let app = Router::new()
        .route("/users/{name}", get(handle_user))
        .route("/", get(root));

    // add a fallback service for handling routes to unknown paths
    let app = app.fallback(not_found_page);

    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000").await.unwrap();
    println!("Listening on {}", listener.local_addr().unwrap());
    axum::serve(listener, app)// Connection limits
        .with_graceful_shutdown(shutdown_signal())
        .await
        .unwrap();
}

async fn shutdown_signal() {
    tokio::signal::ctrl_c()
        .await
        .expect("Failed to install CTRL+C handler");
}