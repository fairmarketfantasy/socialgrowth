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
		name = children[subelement].name
		id = children[subelement].id
		children[subelement].name = incrementName(name, model, association, attributes[i]) if shouldReplace(name, attributes[i])
		children[subelement].id = incrementId(id, model, association, attributes[i]) if shouldReplace(id, attributes[i])
		children[subelement].innerHTML = ""
		children[subelement].value = "" if children[subelement].type != "hidden"
		i++

	unorderedList.append liTemplate

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

App.toggleCampaignActivity = toggleCampaignActivity
Rails.addAssociation = addAssociation