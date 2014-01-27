initKeyDetection = ->
	$("#campaign_search_string").keypress (event) ->
		handleKeyPress event

	$(".cam-pane").click ->
		console.log($(this))
		App.toggleCampaignActivity($(this).attr("data-id"))

handleKeyPress = (event) ->
	if event.keyCode is 13
		searchForTweets 20
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

setResultContent = (data) ->
	$("#results").html "<p>Search results: </p>"
	if data == false then $("#results").append("<div class='results-area'>No results found</div>")
	else
		for text of data
			$("#results").append formatTweet(data[text])

formatTweet = (tweet) ->
	return "<div class='results-area'><p>#{tweet.author}<span class='pull-right'>#{tweet.date}</span></p><p>#{tweet.text}</p></div>"

$(document).on('page:load', initKeyDetection)
$(document).ready(initKeyDetection)

$(document).on 'keypress', '#campaign_search_string', ->
	handleKeyPress event
