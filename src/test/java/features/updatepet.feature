Feature: Update an existed pet

  Background: The Request Body Configuration
    # Set a configuration for the payload
    * url baseUrl
    * def requestPayload = read('classpath:payload/pet.json')
    * set requestPayload.id = Java.type('utils.TestDataCreator').getID()
    * set requestPayload.category.id = Java.type('utils.TestDataCreator').getID()
    * set requestPayload.category.name = Java.type('utils.TestDataCreator').getDogCategoryName()
    * set requestPayload.name = Java.type('utils.TestDataCreator').getDogName()
    * set requestPayload.photoUrls[0] = Java.type('utils.TestDataCreator').getFileName()
    * set requestPayload.tags[0].name = requestPayload.name
    * set requestPayload.status = Java.type('utils.TestDataCreator').getStatus()[0]

  Scenario: Updates the pet in the store
    # Create a new pet as the precondition
    Given header Content-Type = 'application/json'
    And path '/v2/pet'
    And request requestPayload
    When method post
    Then status 200
    # Create a new pet name & status for updating them.
    * def newName = Java.type('utils.TestDataCreator').getCatName()
    * def newStatus = Java.type('utils.TestDataCreator').getStatus()[2]
    # Send the update request
    Given header Content-Type = 'application/x-www-form-urlencoded'
    And  path '/v2/pet/' + requestPayload.id
    And form field name = newName
    And form field status = newStatus
    When method post
    Then status 200
    * print response