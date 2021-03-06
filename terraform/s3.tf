provider "aws" {
  region = "us-east-1"
  profile = "chicago-haskell"
}

resource "aws_s3_bucket" "www" {
  bucket = "www.chicagohaskell.com"
  policy = "${file("policy.json")}"

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket" "apex" {
  bucket = "chicagohaskell.com"

  website {
    redirect_all_requests_to = "${aws_s3_bucket.www.id}"
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket = "${aws_s3_bucket.www.id}"
  key = "index.html"
  source = "../site/index.html"
  content_type = "text/html"
  etag = "${md5(file("../site/index.html"))}"
}

resource "aws_s3_bucket_object" "style" {
  bucket = "${aws_s3_bucket.www.id}"
  key = "assets/css/style.css"
  source = "../site/assets/css/style.css"
  content_type = "text/css"
  etag = "${md5(file("../site/assets/css/style.css"))}"
}

resource "aws_s3_bucket_object" "header" {
  bucket = "${aws_s3_bucket.www.id}"
  key = "assets/img/Chicago_tilt-shift.jpg"
  source = "../site/assets/img/Chicago_tilt-shift.jpg"
  content_type = "image/jpg"
  etag = "${md5(file("../site/assets/img/Chicago_tilt-shift.jpg"))}"
}

resource "aws_s3_bucket_object" "watermark" {
  bucket = "${aws_s3_bucket.www.id}"
  key = "assets/img/chicago-haskell-watermark.png"
  source = "../site/assets/img/chicago-haskell-watermark.png"
  content_type = "image/png"
  etag = "${md5(file("../site/assets/img/chicago-haskell-watermark.png"))}"
}

resource "aws_s3_bucket_object" "map" {
  bucket = "${aws_s3_bucket.www.id}"
  key = "assets/img/pivotal-map.png"
  source = "../site/assets/img/pivotal-map.png"
  content_type = "image/png"
  etag = "${md5(file("../site/assets/img/pivotal-map.png"))}"
}
