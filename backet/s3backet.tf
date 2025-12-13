terraform {
    required_providers {
        twc = {
            source = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud"
        }
    }
    required_version = ">= 0.13"
}

provider "twc" {
    token = "eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCIsImtpZCI6IjFrYnhacFJNQGJSI0tSbE1xS1lqIn0.eyJ1c2VyIjoibmEwODE5NiIsInR5cGUiOiJhcGlfa2V5IiwiYXBpX2tleV9pZCI6IjlhM2IwZDViLTFhODMtNDE2Yy04NjYwLWZjMzA0ZGM1MTQ3YSIsImlhdCI6MTc2MjQ4NTY3MywiZXhwIjoxNzcwMjYxNjcyfQ.l5wRQS03Irl3DsvruQ7np_B7XpIb7pztirK58NPfBXnTWad_Z6VMKZ8981cGI8Q0fvBeiHXZuWdh8wwyc55LmFmzb6sZxw-nrDBfYtAp1ODcxYJIihwJV4dif_5B1h1XPsIq0IoNf9O_gX_zQhnvPs4pSihSFo1Azf_ngBfvUWo-3-0jBN5l90Zk78yzV2t83Z8OiijX2bQhIhwCZlR3WS0XbsfLRGl7z5J_TUcCsbWysoNqlaE9e49DurZeOu7MRvI2PLzkQhqCnRFY_2PEFM-rvFBY1jd2NkUI6zSoyJB00a5gF657VjrPqxQ66B7lbXa_Icjzf2qJezf971mGGIJG1iKx9GYkDMPkOmhB-hqb--44rjdLHlUgh8RBIxNTjguBEtzlITZguTygZDuQ41P3TF8GYoOArKVBB2pvkBpThaMZCxxxFuXEQo6kq3T6Mxdl9lrFm_saN9dWuilLVUY3Ce-0ils-IJYQ46M8jwkhAuATK4bf-tXXlv8bmTRf"
}

resource "twc_s3_bucket" "diplom" {
	name = "diplom"
	preset_id = 2623
	type = "public"
	project_id = 1883199
}