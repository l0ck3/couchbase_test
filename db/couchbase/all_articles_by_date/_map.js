function(doc){
  if(doc.type && doc.type == 'article') {
    emit(doc.created_at, {
      id: doc.id,
      title: doc.title,
      content: doc.content,
      username: doc.username,
      user_id: doc.user_id,
      created_at: doc.created_at
    });
  }
}


