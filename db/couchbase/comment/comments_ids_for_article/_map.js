function(doc, meta) {
  if (doc.type && doc.type == 'comment') {
    emit(doc.article_id, meta.id)
  }
}


