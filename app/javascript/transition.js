const locText =
  document.querySelector('p');

locText.addEventListener('animationend', () => {
  locText.classList.remove('active');
});

const sections =
  [].slice.apply(document.querySelectorAll('section'));

const transitioners =
  [].slice.apply(document.querySelectorAll('a'));

const transitions = [];
let current = '';

// sections.forEach((section, index) => {
//   if(window.location.pathname.indexOf(section.getAttribute('data-path')) != -1) {
//     section.classList.add('transition-enter');
//   }
//   else if(window.location.pathname.indexOf('index.html') != -1 && index == 0) {
//     section.classList.add('transition-enter');
//   }
//   else if(window.location.pathname == '/' && index == 0) {
//     section.classList.add('transition-enter');
//   }
//   else {
//     section.classList.add('transition-leave');
//   }
// });

transitioners.forEach((t, i) => {
  const transition = {
    id: i,
    trigger: t,
    from: {
      id: t.getAttribute('data-from'),
      el: document.querySelector(`[data-path="${t.getAttribute('data-from')}"]`)
    },
    to: {
      id: t.getAttribute('href'),
      el: document.querySelector(`[data-path="${t.getAttribute('href')}"]`)
    }
  }
  // console.log(transition.from, transition.to)
  transitions.push(transition);
});

transitions.forEach(t => {
  t.trigger.onclick = (evt) => {
    evt.preventDefault();

    const newState = {
      from: t.from.id,
      to: t.to.id
    };

    window.history.pushState(newState, `section ${t.to.id}`, t.to.id);

    const indexFrom = sections.findIndex(el => el.getAttribute('data-path') == t.from.id);
    const indexTo = sections.findIndex(el => el.getAttribute('data-path') == t.to.id);

    console.log(indexFrom, indexTo)

    if(indexFrom < indexTo) {
      t.from.el.classList.remove('transition-enter');
      t.from.el.classList.remove('transition-enter-right');
      t.from.el.classList.remove('transition-enter-left');
      t.from.el.classList.add('transition-leave-left');

      t.to.el.classList.remove('transition-leave');
      t.to.el.classList.remove('transition-leave-right');
      t.to.el.classList.remove('transition-leave-left');
      t.to.el.classList.add('transition-enter-right');
    }
    else {
      t.from.el.classList.remove('transition-enter');
      t.from.el.classList.remove('transition-enter-right');
      t.from.el.classList.remove('transition-enter-left');
      t.from.el.classList.add('transition-leave-right');

      t.to.el.classList.remove('transition-leave');
      t.to.el.classList.remove('transition-leave-left');
      t.to.el.classList.remove('transition-leave-right');
      t.to.el.classList.add('transition-enter-left');
    }

    current = newState.to;
    locText.textContent = window.location.pathname.match(/\/(section-\d|index.html|\/)$/)[0];
    locText.classList.add('active');
  }
});

window.onpopstate = (evt) => {
  const from = document.querySelector(`[data-path="${current}"]`);
  const to = document.querySelector(`[data-path="${
    window.location.pathname.match(/section-\d/) ? window.location.pathname.match(/section-\d/)[0] : 'section-1'
  }"]`);

  if(!from || !to) return;

  const indexFrom = sections.findIndex(el =>
    el.getAttribute('data-path') == from.getAttribute('data-path')
  );
  const indexTo = sections.findIndex(el =>
    el.getAttribute('data-path') == to.getAttribute('data-path')
  );

  if(indexFrom < indexTo) {
    from.classList.remove('transition-enter-right');
    from.classList.remove('transition-enter-left');
    from.classList.add('transition-leave-left');

    to.classList.remove('transition-leave-right');
    to.classList.remove('transition-leave-left');
    to.classList.add('transition-enter-right');
  }
  else {
    from.classList.remove('transition-enter-right');
    from.classList.remove('transition-enter-left');
    from.classList.add('transition-leave-right');

    to.classList.remove('transition-leave-left');
    to.classList.remove('transition-leave-right');
    to.classList.add('transition-enter-left');
  }

  current = to.getAttribute('data-path');
  locText.textContent =
    window.location.pathname.match(/\/(section-\d|index.html|\/)$/)
    ? window.location.pathname.match(/\/(section-\d|index.html|\/)$/)[0]
    : '/';
  locText.classList.add('active');
}
