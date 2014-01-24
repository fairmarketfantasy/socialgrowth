# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.Rails ||= {}
window.App ||= {}

getLiTemplate = (name) ->
	name = "##{name.replace "_", "-"} li:last-of-type"
	return $(name).clone()

getUl = (name) ->
	name = "##{name.replace "_", "-"}"
	return $(name)

addAssociation = (model, association, attributes) ->
	unorderedList = getUl association
	liTemplate = getLiTemplate association

	children = liTemplate.children()

	i = 0

	for subelement of children
		if(subelement.tagName != "INPUT" || subelement.tagName != "TEXTAREA") 
			continue
			
		name = children[subelement].name
		id = children[subelement].id
		children[subelement].name = incrementName(name, model, association, attributes[i]) if shouldReplace(name, attributes[i])
		children[subelement].id = incrementId(id, model, association, attributes[i]) if shouldReplace(id, attributes[i])
		children[subelement].innerHTML = ""
		children[subelement].value = "" if children[subelement].type != "hidden"
		i++

	unorderedList.append liTemplate

showDeleteError = (string) ->
	panel = $(".conversation-error")
	panel.html(string)
	panel.css({ opacity: 1, display: "block" })
	setTimeout(() ->
		panel.fadeTo("slow", 0, () -> panel.css({ opacity: 0, display: "none" }))
	, 2000)

removeAssociation = (item) ->
	count = $("##{item.parent().attr('id')} li").length
	if count <= 1
		return showDeleteError("Can't delete your only conversation")
	item.remove()

initRemoveListeners = ->
	$(document).on("click", ".remove-association", ->
		removeAssociation($(this).parent())
	)

shouldReplace = (HtmlAttribute, modelField) -> 
	return HtmlAttribute && HtmlAttribute.indexOf modelField > -1
	
incrementName = (name, model, association, attribute) ->
	temp = name.replace model, ""
	temp = temp.replace "[#{association}_attributes]", ""
	temp = temp.replace "[#{attribute}]", ""
	temp = temp.replace "[", ""
	temp = temp.replace "]", ""
	number = parseInt(temp) + 1
	temp = "#{model}[#{association}_attributes][#{number}][#{attribute}]"
	return temp

incrementId = (name, model, association, attribute) ->
	temp = name.replace model, ""
	temp = temp.replace "_#{association}_attributes_", ""
	temp = temp.replace "_#{attribute}", ""
	number = parseInt(temp) + 1
	temp = "#{model}_#{association}_attributes_#{number}_#{attribute}"
	return temp

toggleCampaignActivity = (campaignId) -> 
	$.ajax
		type: 'get'
		dataType: 'json'
		url: '/campaigns/toggle'
		data: 
			id: campaignId

		success: (data) -> loadCampaignPane(data, campaignId)

loadCampaignPane = (shouldLoad, campaignId) ->
	$("[data-id=#{campaignId}]").load("/campaigns/#{campaignId}/pane")

ready = ->
	initRemoveListeners()

$(document).on('page:load', ready)
$(document).ready(ready)
App.toggleCampaignActivity = toggleCampaignActivity
Rails.addAssociation = addAssociation