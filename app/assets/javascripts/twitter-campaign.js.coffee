$(document).on('page:load', initKeyDetection)
$(document).ready(initKeyDetection)

$(document).on 'keypress', '#campaign_search_string', ->
	handleKeyPress event

initKeyDetection = ->
	$("#campaign_search_string").keypress (event) ->
		handleKeyPress event

handleKeyPress = (event) ->
	if event.keyCode is 13
		searchForTweets 1
		return false

$(document).on 'click', '.campaign-panel li', ->
	window.location = "/campaigns/" + $(@).data().id + "/edit"

searchForTweets = (count) ->
	searchString = $('#campaign_search_string').val()
	console.log searchString
	$.ajax
		type: 'get'
		dataType: 'json'
		url: '/campaigns/search'
		data: 
			string: searchString
			count: count

		success: (data) -> setResultContent data

setResultContent = (text) ->
	$('#results').html text
