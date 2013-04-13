API Documentation
======================================

The following examples use `curl` command to get the response from the server.

Sign in
-------
To authenticate you need `client_id`, which is the `uid` of application, `email` and `password` of an user. For example:
> curl "http://api.coursewa.re/oauth/authenticate?client_id=f2840c1ddfa2d03e21f64d68a5cde21502f19ad145daf2cf71d3eb336b21ba29&email=calin@coursewa.re&password=secret"

And the response should be:
> ```json
{
  "error":false,
  "accesss_token":"d26642e0b5af0799ea4214f5efaeebb9af36a3f0b35145650eb7a39b56e9ef79"
}

Otherwise, if `client_id`, `email` or `password` are wrong, the response is:
> ```json
{
  "error":true
}

In order to revalidate the token, you can send it over:

> curl "http://api.coursewa.re/oauth/authenticate?access_token=d26642e0b5af0799ea4214f5efaeebb9af36a3f0b35145650eb7a39b56e9ef79"

If the token is valid, you will get a response like below:

> ```json
{
  "error":false, "access_token":"d26642e0b5af0799ea4214f5efaeebb9af36a3f0b35145650eb7a39b56e9ef79"
}

Now you can use the `accesss_token` to request data from the server. In the following commands we will use the `access_token` as ACCES_TOKEN.

Classrooms
----------

To request information about classrooms that user is attended use following link:
> curl "http://api.coursewa.re/v1/classrooms?accesss_token=ACCESS_TOKEN"

Response:
> ```json
{
  "classrooms":[{
    "id":1,
    "description":"Aspernatur officiis accusantium voluptates earum perferendis cupiditate minima molestiae.",
    "title":"University of Georgia",
    "owner":{
      "id":1,
      "email":"calin@coursewa.re",
      "first_name":"Leopoldo",
      "last_name":"Hintz"
    }
  }]
}

To request information about a specified classroom, you should put the id of classroom in the link:
> curl "http://api.coursewa.re/v1/classrooms/:id?access_token=ACCESS_TOKEN"

Response:
> ```json
{
  "classroom":{
    "id":1,
    "description":"Aspernatur officiis accusantium voluptates earum perferendis cupiditate minima molestiae.",
    "title":"University of Georgia",
    "owner":{
      "id":1,
      "email":"calin@coursewa.re",
      "first_name":"Leopoldo",
      "last_name":"Hintz"
    }
  }
}

To request collaborators of a classroom, you should put the id of classroom:
> curl "http://api.coursewa.re/v1/classrooms/:classroom_id/collaborators?access_token=ACCESS_TOKEN"

Response:
> ```json
{
  "collaborators":[{
    "id":4,
    "email":"madyson@breitenberg.name",
    "first_name":"Derrick",
    "last_name":"Kohler"
  },{
    "id":5,
    "email":"dasia.schmeler@okunevathiel.biz",
    "first_name":"Samson",
    "last_name":"Zboncak"
  }]
}

To request all activities in a classroom that user is attended:
> curl "http://api.coursewa.re/v1/classrooms/:classroom_id/timeline?access_token=ACCESS_TOKEN"

Response:
> ```json
{
  "activities":[{
    "id":26,
    "recipient_type":
    "coursewareable/classroom",
    "trackable_type":"coursewareable/syllabus",
    "owner":{
      "id":1,
      "email":"calin@coursewa.re",
      "first_name":"Leopoldo",
      "last_name":"Hintz"
    },
    "recipient":{
      "id":1,
      "description":"Aspernatur officiis accusantium.",
      "title":"University of Georgia",
      "owner":{
        "id":1,
        "email":"calin@coursewa.re",
        "first_name":"Leopoldo",
        "last_name":"Hintz"
      }
    },
    "trackable":{
      "id":1,
      "title":"Hic rerum eveniet iste fuga dolore omnis fugit.",
      "content":"<h1>Quas reprehenderit</h1><p><strong>Consequatur non</strong>.",
      "intro":"Dolorem perferendis autem nulla.",
      "title":"University of Georgia",
      "owner":{
        "id":1,
        "email":"calin@coursewa.re",
        "first_name":"Leopoldo",
        "last_name":"Hintz"
      }
    }
  },{
    "id":24,
    "recipient_type":"coursewareable/classroom",
    "trackable_type":"coursewareable/association",
    "owner":{
      "id":1,"email":"calin@coursewa.re",
      "first_name":"leopoldo",
      "last_name":"hintz"
    },
    "recipient":{
      "id":1,
      "description":"aspernatur officiis accusantium voluptates earum perferendis cupiditate minima molestiae.",
      "title":"university of georgia",
      "owner":{
        "id":1,
        "email":"calin@coursewa.re",
        "first_name":"leopoldo",
        "last_name":"hintz"
      }
    },
    "trackable":{
      "classroom_id":1,
      "created_at":"2013-04-01t15:50:29z",
      "email_announcement":{
        "send_grades":true,
        "send_announcements":true,
        "send_generic":false
      },
      "id":9,
      "updated_at":"2013-04-01t15:50:29z",
      "user_id":8
    }
  }
}

Syllabus
--------

To request the syllabus of a classroom:
> curl "http://api.coursewa.re/v1/syllabus?classroom_id=:classroom_id&access_token=ACCESS_TOKEN"

Response:
> ```json
{
  "syllabus":{
    "id":1,
    "title":"Hic rerum eveniet iste fuga dolore omnis fugit.",
    "content":"<h1>Quas reprehenderit</h1><p><strong>Consequatur non</strong>. <em>Architecto unde sunt aliquam et sit minima. Fuga quidem exercitationem ullam in iste. Vel unde aliquid quas.</em> <code>sed maiores</code></p><p><strong>Saepe placeat</strong>.",
    "user":{
      "id":1,
      "email":"calin@coursewa.re",
      "first_name":"Leopoldo",
      "last_name":"Hintz"
    }
  }
}

Lectures
--------
To request all lectures which belongs to logged user:
> curl "http://api.coursewa.re/v1/lectures?access_token=ACCESS_TOKEN"

Response:
> ```json
{
  "lectures":[{
    "id":1,
    "slug":"vel-qui-ut-blanditiis-enim-delectus-est",
    "title":"Vel qui ut blanditiis enim delectus est.",
    "content":"<h1>Mollitia omnis</h1><p><code>laborum omnis</code> <em>Quam error autem harum sit atque voluptatibus iusto.</em></p>",
    "requisite":"Ipsam autem non quos velit qui qui beatae occaecati."
  },{
    "id":2,
    "slug":"animi-quia-esse-reprehenderit-ratione-et-quis-in-porro",
    "title":"Animi quia esse reprehenderit ratione et quis in porro.",
    "content":"<h1>Mollitia omnis</h1><p><code>laborum omnis</code> <em>Quam error autem harum sit atque voluptatibus iusto.</em></p>"
    "requisite":"Ipsam autem non quos velit qui qui beatae occaecati."
  }]
}

To request a specified lecture which belongs to logged user:
> curl "http://api.coursewa.re/v1/lectures/:id?access_token=ACCESS_TOKEN"

Response:
> ```json
{
  "lecture":{
    "id":1,
    "slug":"vel-qui-ut-blanditiis-enim-delectus-est",
    "title":"Vel qui ut blanditiis enim delectus est.",
    "content":"<h1>Mollitia omnis</h1><p><code>laborum omnis</code> <em>Quam error autem harum sit atque voluptatibus iusto.</em></p>",
    "requisite":"Ipsam autem non quos velit qui qui beatae occaecati."
  }
}

To request a specified lecture which belongs to classroom:
> curl "http://api.coursewa.re/v1/lectures/:id?classroom_id=:classroom_id&access_token=ACCESS_TOKEN"

Response:
> ```json
{
  "lecture":{
    "id":1,
    "slug":"vel-qui-ut-blanditiis-enim-delectus-est",
    "title":"Vel qui ut blanditiis enim delectus est.",
    "content":"<h1>Mollitia omnis</h1><p><code>laborum omnis</code> <em>Quam error autem harum sit atque voluptatibus iusto</em></p>",
    "requisite":"Ipsam autem non quos velit qui qui beatae occaecati."
  }
}

Responses
---------

To request a response that belong to logged user:
> curl "http://api.coursewa.re/v1/response?assignment_id=:assignment_id&access_token=ACCESS_TOKEN"

Response:
> ```json
{
  "response":{
    "id":1,
    "content":"<h1>Est sed</h1><p><strong>Cupiditate quo</strong>.<code>alias quos</code></p>Voluptas laudantium iure facilis necessitatibus recusandae pariatur dolores.",
    "quiz":{
      "answers":[{
        "content":"Id fugit reiciendis veniam.",
        "type":"text",
        "options":[{"content":"fugit","valid":true,"wrong":true}]
      },{
        "content":"A esse sit ipsam repellat commodi qui reprehenderit.",
        "type":"checkboxes",
        "options":[{
          "content":"eum",
          "valid":true,
          "wrong":true
        },{
          "content":"aut",
          "valid":false
        },{
          "content":"nihil",
          "valid":true,"wrong":true
        }]
      },{
        "content":"Non distinctio fuga sed consectetur aspernatur atque.",
        "type":"radios",
        "options":[{
          "content":"ab",
          "valid":true,
          "wrong":true
          },{
            "content":"autem",
            "valid":false
          },{
            "content":"blanditiis",
            "valid":false
          }]
      }],
      "coverage":0.0,
      "stats":{"all":4,"wrong":4}
    },
    "user":{
      "id":2,
      "email":"angie@oberbrunner.biz",
      "first_name":"Allen",
      "last_name":"Tromp"
    }
  }
}

Assignments
-----------

To request all assignments which belong to logged user:
> curl "http://api.coursewa.re/v1/assignments?access_token=ACCESS_TOKEN"

Reponse:
> ```json
{
  "assignments":[{
    "id":1,
    "slug":"rem-animi-perferendis-architecto-delectus",
    "title":"Rem animi perferendis architecto delectus.",
    "content":"<h1>Repudiandae enim</h1><table>\n<thead><tr>\n<th>Corporis</th>\n      <th>Molestias</th>\n      <th>Quia</th>\n      <th>Aliquam</th>\n      </tr></thead>\n<tbody></tbody>\n</table><h2>Aperiam illo</h2>Nulla rerum quis provident.",
    "quiz":[{
      "content":"Quisquam occaecati voluptates quo maiores nihil nulla sed tempore.",
      "type":"text",
      "options":[{"content":"cum","valid":true}]
    },{
      "content":"Ut modi est eum neque et aut sint vel.",
      "type":"checkboxes",
      "options":[{
        "content":"nihil",
        "valid":true
      },{
        "content":"libero",
        "valid":false
      },{
        "content":"nisi",
        "valid":true
      }]
    },{
      "content":"Reiciendis ut illo ut numquam.",
      "type":"radios",
      "options":[{
        "content":"architecto",
        "valid":true
      },{
        "content":"magnam",
        "valid":false
      },{
        "content":"voluptatem",
        "valid":false
      }]
    }],
    "user":{
      "id":1,
      "email":"calin@coursewa.re",
      "first_name":"Leopoldo",
      "last_name":"Hintz"
    }
  }
}

To request a specified assigment that belong to a logged user:
> curl "http://api.coursewa.re/v1/assignments/:id?access_token=ACCESS_TOKEN"

Response:
> ```json
{
  "assignment":{
    "id":1,
    "slug":"quibusdam-non-in-quaerat-ea-mollitia-provident",
    "title":"Quibusdam non in quaerat ea mollitia provident.",
    "content":"<h1>Repudiandae enim</h1><table>\n<thead><tr>\n<th>Corporis</th>\n      <th>Molestias</th>\n      <th>Quia</th>\n      <th>Aliquam</th>\n      </tr></thead>\n<tbody></tbody>\n</table><h2>Aperiam illo</h2>Nulla rerum quis provident.",
    "quiz":[{
      "content":"Quisquam occaecati voluptates quo maiores nihil nulla sed tempore.",
      "type":"text",
      "options":[{"content":"cum","valid":true}]
    },{
      "content":"Ut modi est eum neque et aut sint vel.",
      "type":"checkboxes",
      "options":[{
        "content":"nihil",
        "valid":true
      },{
        "content":"libero",
        "valid":false
      },{
        "content":"nisi",
        "valid":true
      }]
    },{
      "content":"Reiciendis ut illo ut numquam.",
      "type":"radios",
      "options":[{
        "content":"architecto",
        "valid":true
      },{
        "content":"magnam",
        "valid":false
      },{
        "content":"voluptatem",
        "valid":false
      }]
    }],
    "user":{
      "id":1,
      "email":"calin@coursewa.re",
      "first_name":"Leopoldo",
      "last_name":"Hintz"
    }
  }
}

To request a specified assigment that belong to a classroom:
> curl "http://api.coursewa.re/v1/assignments/:id?classroom_id=:classroom_id&access_token=ACCESS_TOKEN"

Response:
> ```json
{
  "assignment":{
    "id":1,
    "slug":"quibusdam-non-in-quaerat-ea-mollitia-provident",
    "title":"Quibusdam non in quaerat ea mollitia provident.",
    "content":"<h1>Repudiandae enim</h1><table>\n<thead><tr>\n<th>Corporis</th>\n      <th>Molestias</th>\n      <th>Quia</th>\n      <th>Aliquam</th>\n      </tr></thead>\n<tbody></tbody>\n</table><h2>Aperiam illo</h2>Nulla rerum quis provident.",
    "quiz":[{
      "content":"Quisquam occaecati voluptates quo maiores nihil nulla sed tempore.",
      "type":"text",
      "options":[{"content":"cum","valid":true}]
    },{
      "content":"Ut modi est eum neque et aut sint vel.",
      "type":"checkboxes",
      "options":[{
        "content":"nihil",
        "valid":true
      },{
        "content":"libero",
        "valid":false
      },{
        "content":"nisi",
        "valid":true
      }]
    },{
      "content":"Reiciendis ut illo ut numquam.",
      "type":"radios",
      "options":[{
        "content":"architecto",
        "valid":true
      },{
        "content":"magnam",
        "valid":false
      },{
        "content":"voluptatem",
        "valid":false
      }]
    }],
    "user":{
      "id":1,
      "email":"calin@coursewa.re",
      "first_name":"Leopoldo",
      "last_name":"Hintz"
    }
  }
}

Note: all symbols that represents parameters value should be changed.
