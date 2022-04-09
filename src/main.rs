#[macro_use]
extern crate rocket;

use rocket_prometheus::PrometheusMetrics;

#[get("/")]
fn index() -> &'static str {
    "Hello, world!"
}

// #[rocket::main]
// async fn main() {
//     let prometheus = PrometheusMetrics::new();

//     rocket::build()
//         .attach(prometheus.clone())
//         .mount("/", routes![index])
//         .mount("/metrics", prometheus)
//         .launch()
//         .await;
// }

#[rocket::launch]
fn rocket() -> _ {
    let prometheus = PrometheusMetrics::new();

    rocket::build()
        .attach(prometheus.clone())
        .mount("/metrics", prometheus)
        .mount("/", routes![index])
}
