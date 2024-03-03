const String editCartItemAmount = r'''
{
    replies(Function: "getCommentReplies" isDeleted_orderBy: "1"){
        id
        content
        attach
        user{
            username
            active
            birthday
            email
        }
    }
}
''';
