@Entries = new Meteor.Collection 'entries'
@Comments = new Meteor.Collection 'comments'
@Trackbacks = new Meteor.Collection 'trackbacks'

if Meteor.is_client
  Meteor.startup () ->

  Template.admin.events =
    'click button' : (event) ->
      t = $('#text')
      if t.val()?
        Entries.insert
          text: t.val()
          created_at: Date.now()
        t.val("")

  Template.diary.diary = () ->
    title: "naoyaのはてなダイアリー"
    url: 'http://d.hatena.ne.jp/naoya/'
    description: 'naoyaのはてなダイアリー'

  Template.entries.hatenafy = (text) ->
    hatena = new Hatena sectionanchor : "_"
    hatena.parse text
    return hatena.html()

  Template.entries.entries = () ->
    return Entries.find {}, { sort: {created_at: -1} }

  Template.comments.comments = () ->
    return Comments.find {}, { sort: {posted_at: 1} }

  Template.trackbacks.trackbacks = () ->
    return Trackbacks.find {}, { sort: {received_at: 1} }

  Template.comments.proficon = (username) ->
    substr = username.substr 0, 2
    return "<img src=\"http://www.hatena.ne.jp/users/#{substr}/#{username}/profile_s.gif\" class=\"hatena-id-icon\" height=\"16\" width=\"16\" />"

if Meteor.is_server
  Meteor.startup () ->