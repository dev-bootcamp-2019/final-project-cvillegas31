import React, { Component } from 'react'
import { connect }            from 'react-redux'
import { bindActionCreators } from 'redux'
import PropTypes            from 'prop-types'
import { withRouter, Link } from 'react-router-dom'

import * as assetActionCreators from 'core/actions/actions-asset'

class SuccessPanel extends Component {
  render() {
    return (
      <div className="notification">
        <h2>Congratulations! Your photo was successfully registered.</h2>
        <span className="action"><Link to="/assets" onClick={this.getAssets}>See your photo assets</Link></span>
      </div>
    )
  }

  getAssets = () => {
    const { actions } = this.props
    actions.asset.assets()
  }
}

function mapStateToProps(state) {
  return {
    account: state.account,
    asset: state.asset
  }
}

function mapDispatchToProps(dispatch) {
  return {
    actions: {
      asset: bindActionCreators(assetActionCreators, dispatch)
    }
  }
}

SuccessPanel.propTypes = {
  history: PropTypes.object.isRequired
}

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(SuccessPanel))
