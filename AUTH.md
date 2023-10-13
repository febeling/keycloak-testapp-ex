# Auth Code Flow

@startuml
participant Browser
note left of Browser
  Not trusted, so Browser
  can't have the tokens. 
  They stay on Server.
end note
participant Server
participant IdP

group SessionController.create
Browser -> Server : sign_in
Server -> IdP : authorize
IdP -> Server : consent_url=consent_page
Server -> Browser : redirect(consent_page: "You consent?")
end
|||
Browser -> IdP : consent_page
IdP -> Browser : Form: "You consent?"
Browser -> IdP : OK
|||
group SessionController.callback
IdP -> Server : callback(auth_code)
note right
  URL of this is 
  not controlled by 
  Browser
end note
Server -> IdP : get_token(auth_code)
IdP -> Server : token (ID and access)
Server -> Browser : redirect(notice="You're signed in")
end
@enduml

https://plantuml.nowtech.io/svg/VL9TIyD047o_Nx7uqXQqFw1G1HMXA2f-FFWKhfTjSZJUXhrDfT8Vx-QhfYqA2IGxbvdPcPIMnJjVsY1mpVGLaKqWGIXm9K2h_H3WaGI4goYOdaEa0U9i60daTeCWkTwqnX2deCXRZbk8OhT00LwHDyXJWo65MiEK0_4MF1WjqcTZCgQgL3H6J-66WZ0LXR8uHgiKdGcukEmOO0RHPo7nmNG3XPH9vxQIdDX_ewdVXryu2X6391KNy_wvj1aEA7gX6J2cdj79U7Xo1cSVLFL4LsUJUakps-s63biR1mATar_sE-BFOx9JZgVxXllFS6nHBArRdoxQ0UCwYyHHYfEsRlPPBbhO-yj3tRhaFe9UEb6uTj9Ifx3SriE--tsLnrbdA4dp7moLZjqq1s2yk0MhFDOvNMJoV-OgvXtEwtn6Z4tLQig7Dl0V

https://plantuml.com/en/sequence-diagram
