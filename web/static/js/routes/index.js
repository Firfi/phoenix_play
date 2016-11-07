import React from 'react';
import { Route, IndexRoute } from 'react-router';

import AppContainer from 'containers/App';
import Main from 'components/Main';
import LoginContainer from 'containers/Login';


export default (<Route path="/app" component={ AppContainer }>
    <IndexRoute component={ Main }/>
    <Route path="login" component={ LoginContainer }/>
</Route>);