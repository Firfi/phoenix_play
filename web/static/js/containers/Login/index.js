import { connect } from 'react-redux'
// import { setVisibilityFilter } from './actions'
import Login from 'components/Login'

const mapStateToProps = (state, ownProps) => {
    return {
        test: 'test'
    }
};

const mapDispatchToProps = (dispatch, ownProps) => {
    return {
        onClick: () => {
            console.warn('test');
        }
    }
};

const LoginContainer = connect(
    mapStateToProps,
    mapDispatchToProps
)(Login);

export default LoginContainer