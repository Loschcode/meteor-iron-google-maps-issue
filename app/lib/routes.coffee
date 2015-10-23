Router.configure
  layoutTemplate: 'MasterLayout'
  loadingTemplate: 'Loading'
  notFoundTemplate: 'NotFound'


Router.route '/',
  name: 'home'
  controller: 'HomeController'
  where: 'client'
  
#Router.onBeforeAction (->

#  if (Meteor.isCordova)
#    alert('onBeforeAction')

#  GoogleMaps.load()
#  @next()

#), only: ['home']