function(doc){
  if(doc.type && doc.type == 'comment' && doc.moderation && doc.moderation != null) {
    emit([doc.article_id, doc.created_at], {
      id: doc.id,
      content: doc.content,
      username: doc.username,
      user_id: doc.user_id,
      created_at: doc.created_at,
      moderation: doc.moderation
    });
  }
}


