initKeyDetection = ->
	$("#campaign_search_string").keypress (event) ->
		handleKeyPress event

	$(".cam-pane").click ->
		console.log($(this))
		App.toggleCampaignActivity($(this).attr("data-id"))

handleKeyPress = (event) ->
	if event.keyCode is 13
		searchForTweets 1
		return false

searchForTweets = (count) ->
	searchString = $('#campaign_search_string').val()
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

$(document).on('page:load', initKeyDetection)
$(document).ready(initKeyDetection)

$(document).on 'keypress', '#campaign_search_string', ->
	handleKeyPress event
