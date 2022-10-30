Feature: Finds Pets by status

  Background:
    # Set a configuration
    * url baseUrl

  Scenario Outline: Find pets by status
    Given header Content-Type = 'application/json'
    And path '/v2/pet/findByStatus'
    And params {status:<status>}
    When method get
    Then status 200
    And match response[0].status contains <status>
    * print response.length

    Examples:
      | status      |
      | 'available' |
      | 'pending'   |
      | 'sold'      |

