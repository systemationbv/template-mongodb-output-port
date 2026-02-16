{% set domainNameNormalized = values.domain | replace(r/domain:| |-/, "") %}
{% set dataProductNameNormalized = values.dataproduct.split(".")[1] | replace(r/ |-/g, "") %}
{% set dataProductMajorVersion = values.identifier.split(".")[2] %}
{% set componentNameNormalized = values.name.split(" ") | join("") | lower %}

{% set dataProductNameWithTrims = values.dataproduct.split(".")[1] | replace(r/ /g, "-") %}
{% set domainNameWithTrims = values.domain.split(":")[1] | replace(r/ /g, "-") %}
{% set componentNameWithTrims = values.name.split(" ") | join("-") | lower %}


## Component basic information

| Field name              | Example value                                      |
|:------------------------|:---------------------------------------------------|
| **Name**                | ${{ values.name }}                                |
| **Description**         | ${{ values.description }}                         |
| **Domain**              | ${{ values.domain }}                              |
| **Data Product**        | ${{ values.dataproduct }}                         |
| **_Identifier_**        | ${{ values.identifier }}                          |
| **_Development Group_** | ${{ values.developmentGroup }}                    |
| **Depends On**          | ${{ values.dependsOn }}                           |


## Subcomponents details
{% for item in values.components %}
| **Field Name**       | **Value**                       |
|----------------------|---------------------------------|
| **description**      | ${{ item.description }}         |
| **collection**       | ${{ item.collection }}          |
| **jsonSchema**       | ${{ item.jsonschema | dump }}          |
{% endfor %}
