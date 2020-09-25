/**
 * ⚠ These are used just to render the Sidebar!
 * You can include any link here, local or external.
 *
 * If you're looking to actual Router routes, go to
 * `routes/index.js`
 */
const routes = [
  {
    path: '/app/dashboard', // the url
    icon: 'HomeIcon', // the component being exported from icons/index.js
    name: 'Dashboard', // name that appear in Sidebar
  },
  {
    path: '#',
    icon: 'FormsIcon',
    name: 'Profile',
  },
  {
    path: '/app/forms',
    icon: 'FormsIcon',
    name: 'Campaign',
  },
  {
    path: '#',
    icon: 'CardsIcon',
    name: 'Beneficiaries',
  },
  {
    path: '#',
    icon: 'ChartsIcon',
    name: 'Vendors',
  },
  {
    path: '#',
    icon: 'ButtonsIcon',
    name: 'Transactions',
  },
  {
    path: '#',
    icon: 'ModalsIcon',
    name: 'Market',
  },
  {
    path: '#',
    icon: 'TablesIcon',
    name: 'Cash For Work',
  },
  {
     path: '#',
    icon: 'TablesIcon',
    name: 'Settings',
  },
  {
    path: '#',
    icon: 'TablesIcon',
    name: 'Support',
  },
  {
    path: '#',
    icon: 'TablesIcon',
    name: 'Log Out',
  },
  // {
  //   icon: 'PagesIcon',
  //   name: 'Pages',
  //   routes: [
  //     // submenu
  //     {
  //       path: '/login',
  //       name: 'Login',
  //     },
  //     {
  //       path: '/create-account',
  //       name: 'Create account',
  //     },
  //     {
  //       path: '/forgot-password',
  //       name: 'Forgot password',
  //     },
  //     {
  //       path: '/app/404',
  //       name: '404',
  //     },
  //     {
  //       path: '/app/blank',
  //       name: 'Blank',
  //     },
  //   ],
  // },
]

export default routes
