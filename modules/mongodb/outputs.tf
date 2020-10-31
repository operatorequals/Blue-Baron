output "name"{
  value = helm_release.mongodb.name
}

output "mongodb-svc-dns"{
  value = "${helm_release.mongodb.name}.${helm_release.mongodb.namespace}"
}

output "mongodb-secret"{
  value = "${helm_release.mongodb.name}"
}
