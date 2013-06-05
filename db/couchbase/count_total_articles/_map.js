function(doc){
  if(doc.type && doc.type == 'article') {
    emit(doc.id, null);
  }
}


