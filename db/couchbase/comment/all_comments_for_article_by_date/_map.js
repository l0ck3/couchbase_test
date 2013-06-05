function(doc){
  moderation = doc.moderation ? doc.moderation : 'null'
  if(doc.type && doc.type == 'comment') {
    emit([doc.article_id, moderation, doc.created_at], {
      id: doc.id,
      content: doc.content,
      username: doc.username,
      user_id: doc.user_id,
      created_at: doc.created_at,
      moderation: moderation
    });
  }
}
