import "strings"

let splits = strings.Split(id, ":")
let domain = splits[3]
let dp_name = splits[4]
let majorVersion = splits[5]

#Id:            string & =~"^[a-zA-Z0-9:._\\-]+$"
#ComponentId:   #Id & =~"^urn:dmb:cmp:\(domain):[a-zA-Z0-9_\\-]+:\(majorVersion):[a-zA-Z0-9_\\-]+$"
#DatabaseName:  string & =~"^\(domain)_\(dp_name)_\(majorVersion)_(development|qa|production)$"
#SubComponentId: string & =~"^urn:dmb:cmp:\(domain):[a-zA-Z0-9_\\-]+:\(majorVersion):[a-zA-Z0-9_\\-]+:[a-zA-Z0-9 _-]+$"

#OM_Tag: {
	tagFQN!:      string
	description?: string | null
	source!:      string & =~"(?i)^(Tag|Glossary)$"
	labelType!:   string & =~"(?i)^(Manual|Propagated|Automated|Derived)$"
	state!:       string & =~"(?i)^(Suggested|Confirmed)$"
	href?:        string | null
	...
}

#DataContract: {
	SLA: {
		intervalOfChange?: string | null
		timeliness?:       string | null
		upTime?:           string | null
		...
	}
	termsAndConditions?: string | null
	...
}

#DataSharingAgreement: {
	purpose?:         string | null
	billing?:         string | null
	security?:        string | null
	intendedUsage?:   string | null
	limitations?:     string | null
	lifeCycle?:       string | null
	confidentiality?: string | null
	...
}

#SubComponents: #BaseComponent &{
	id!: #SubComponentId
	dependsOn?: 	[]
	specific!: {
		collection!: string
		valueSchema!: {
			type!:      "JSON"
			definition!: string & =~#"(?s)^\s*\{\s*"\$jsonSchema"\s*:\s*\{.*\}\s*\}\s*$"#
		}
	}
	...
}

#BaseComponent: {
	description!:              string
	name!:                     string
	fullyQualifiedName?:       null | string
	kind!:                     "outputport"
	version!:                  string
	infrastructureTemplateId!: string
	useCaseTemplateId!:        string
	platform!:            string & =~"(?i)^(MongoDB)$"
	technology!:          string & =~"(?i)^(MongoDB)$"
	outputPortType!:      "SQL"
	dataContract:         #DataContract
	dataSharingAgreement: #DataSharingAgreement
	tags?: [... #OM_Tag]
	consumable!:         bool
	shoppable!:          bool
	...
}

id!: 				#ComponentId
#BaseComponent
dependsOn?: 		[...#ComponentId]
specific: {
	database!:      #DatabaseName
}
components!:        [... #SubComponents]
