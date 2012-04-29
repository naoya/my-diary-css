@Entries = new Meteor.Collection 'entries'

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
    title: "Naoya's Hatena Diary"
    url: 'http://d.hatena.ne.jp/naoya/'
    description: 'naoyaのはてなダイアリー'

  Template.entries.hatenafy = (text) ->
    hatena = new Hatena sectionanchor : "■"
    hatena.parse text
    return hatena.html()

  Template.entries.entries = () ->
    return Entries.find {}, { sort: {created_at: -1} }

if Meteor.is_server
  Meteor.startup () ->