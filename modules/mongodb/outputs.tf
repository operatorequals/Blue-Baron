output "name"{
  value = helm_release.mongodb.name
}

output "mongodb-headless"{
  value = "${helm_release.mongodb.name}-headless"
}

output "mongodb-secret"{
  value = "${helm_release.mongodb.name}"
}