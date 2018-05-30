import Vue from 'vue/dist/vue.esm'
import TurbolinksAdapter from 'vue-turbolinks'
import VueResource from 'vue-resource'

Vue.use(VueResource)
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  Vue.http.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

  var element = document.getElementById("school-form")
  if (element != null) {

    var id = element.dataset.id
    var school = JSON.parse(element.dataset.school)

    var app = new Vue({
      el: element,
      data: function() {
        return { id: id, school: school }
      },
      methods: {
        saveSchool: function() {
          // Create a new school
          if (this.id == null) {
            this.$http.post('/schools', { school: this.school }).then(response => {
              Turbolinks.visit(`/school/${response.body.id}`)
            }, response => {
              console.log(response)
            })

          // Edit an existing school
          } else {
            this.$http.put(`/schools/${this.id}`, { school: this.school }).then(response => {
              Turbolinks.visit(`/schools/${response.body.id}`)
            }, response => {
              console.log(response)
            })
          }
        },

        existingSchool: function() {
          return this.school.id != null
        }

      }
    })

  }
})